# frozen_string_literal: true

module Milvus
  class Databases < Base
    PATH = "databases"

    # This operation alters a database.
    #
    # @param db_name [String] The name of the database to alter.
    # @param properties [String] The new properties of the database.
    # @return [Hash] Server response
    def alter(db_name:, properties:)
      response = client.connection.post("#{PATH}/alter") do |req|
        req.body = {
          dbName: db_name,
          properties:
        }
      end
      response.body
    end

    # This operation creates a new database.
    #
    # @param db_name [String] The name of the database to be created.
    # @param properties [String] The properties of the new database.
    # @return [Hash] Server response
    def create(db_name:, properties: nil)
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          dbName: db_name
        }
        req.body[:properties] = properties if properties
      end
      response.body.empty? ? true : response.body
    end

    # This operation describes a database.
    #
    # @param db_name [String] The name of the database to describe.
    # @return [Hash] Server response
    def describe(db_name:)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          dbName: db_name
        }
      end
      response.body
    end

    # This operation lists all databases.
    #
    # @return [Hash] Server response
    def list
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
      end
      response.body
    end

    # This operation drops the database and all collections within the database.
    #
    # @param db_name [String] The name of the database to drop.
    # @return [Hash] Server response
    def drop(db_name:)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          dbName: db_name
        }
      end
      response.body.empty? ? true : response.body
    end

  end
end
