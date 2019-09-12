# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Authentication strategy for Wonde
    #
    # Wonde implements OAuth 2 (three legged)
    class Wonde < OmniAuth::Strategies::OAuth2
      USER_INFO_URL = "https://api.wonde.com/graphql/me"

      option :name, "wonde"
      option :provider_ignores_state, true
      option :authorize_options, %i[scope redirect_uri]
      option :client_options,
        site: "https://edu.wonde.com",
        authorize_url: "https://edu.wonde.com/oauth/authorize",
        token_url: "https://api.wonde.com/oauth/token"

      uid { raw_info.dig("Me", "id") }

      info do
        me = raw_info.dig("Me", "Person") || {}
        prune!(
          first_name: me["forename"],
          last_name: me["surname"],
          middle_names: me["middle_names"],
          person_id: me["id"],
          person_type: me["type"],
          school_id: me.dig("School", "id"),
          school_name: me.dig("School", "name"),
          upi: me["upi"]
        )
      end

      extra do
        prune!(
          raw_info: raw_info
        )
      end

      # @return [String] JSON string
      def self.user_query_body
        @user_query_body ||= begin
          gql = File.read(File.expand_path("user_data.graphql", __dir__))
          { query: gql }.to_json
        end
      end

      # @return [Hash]
      def raw_info
        @raw_info ||= begin
          data = fetch_user_info.parsed || {}
          data["data"] || {}
        end
      end

      # @return [String]
      def callback_url
        options[:redirect_uri] ||
          (
            full_host +
            script_name +
            callback_path
          )
        # "#{full_host}#{script_name}#{callback_path}"
      end

      private

      # Retrieve basic user info
      #
      # POST to Wonde GraphQL API
      def fetch_user_info
        access_token.post(USER_INFO_URL) do |req|
          req.headers['Content-Type'] = "application/json"
          req.body = self.class.user_query_body
        end
      end

      # Remove empty values from hash
      #
      # @param hash [Hash]
      # @return [Hash]
      def prune!(hash)
        hash.delete_if do |_, v|
          prune!(v) if v.is_a?(Hash)
          v.nil? || (v.respond_to?(:empty?) && v.empty?)
        end
      end
    end
  end
end
