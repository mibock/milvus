# frozen_string_literal: true

module Milvus
  class Collections < Base
    PATH = "collections"

    # This operation checks whether a collection exists.
    #
    # @param collection_name [String] The name of the collection to check.
    # @param db_name [String] The name of the database containing the collection to check (optional).
    # @return [Hash] Server response
    def has(collection_name:, db_name: nil)
      response = client.connection.post("#{PATH}/has") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
      end
      response.body
    end

    # This operation renames an existing collection and optionally moves the collection to a new database.
    #
    # @param collection_name [String] The name of the collection to rename.
    # @param new_collection_name [String] The new name of the collection.
    # @param db_name [String] The name of the database containing the collection (optional).
    # @param new_db_name [String] The name of the database for the renamed collection (optional).
    # @return [Hash] Server response
    def rename(collection_name:, new_collection_name:, db_name: nil, new_db_name: nil)
      response = client.connection.post("#{PATH}/rename") do |req|
        req.body = {
          collectionName: collection_name,
          newCollectionName: new_collection_name
        }
        req.body[:dbName] = db_name if db_name
        req.body[:newDbName] = new_db_name if new_db_name
      end
      response.body.empty? ? true : response.body
    end

    # This operation gets the number of entities in a collection.
    #
    # @param collection_name [String] The name of the collection to get the count of.
    # @param db_name [String] The name of the database containing the collection (optional).
    # @return [Hash] Server response
    def get_stats(collection_name:, db_name: nil)
      response = client.connection.post("#{PATH}/get_stats") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
      end
      response.body
    end

    # Create a Collection
    #
    # @param collection_name [String] The name of the collection to create.
    # @param db_name [String] The name of the database containing the new collection (optional).
    # @param auto_id [Boolean] Whether to automatically generate IDs for the collection.
    # @param description [String] A description of the collection.
    # @param fields [Array<Hash>] The fields of the collection.
    # @param functions [Array<Hash>] The functions for the collection (optional).
    # @return [Hash] Server response
    def create(
      collection_name:,
      db_name: nil,
      auto_id:,
      fields:,
      functions: nil
    )
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          collectionName: collection_name,
          schema: {
            autoId: auto_id,
            fields: fields,
#            functions: functions,
            name: collection_name # This duplicated field is kept for historical reasons.
          }
        }
        req.body[:dbName] = db_name if db_name
        req.body[:schema][:functions] = functions if functions
      end
      response.body.empty? ? true : response.body
    end

    # Describes the details of a collection.
    #
    # @param collection_name [String] The name of the collection to describe.
    # @param db_name [String] The name of the database containing the collection (optional).
    # @return [Hash] Server response
    def describe(collection_name:, db_name: nil)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
      end
      response.body
    end

    # This operation lists all collections in the specified database.
    #
    # @param db_name [String] The name of the database to list the collections for (optional).
    # @return [Hash] Server response
    def list(db_name: nil)
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
        req.body[:dbName] = db_name if db_name
      end
      response.body
    end

    # This operation drops the current collection and all data within the collection.
    #
    # @param collection_name [String] The name of the collection to drop.
    # @param db_name [String] The name of the database of the collection (optional).
    # @return [Hash] Server response
    def drop(collection_name:, db_name: nil)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
      end
      response.body.empty? ? true : response.body
    end

    # Load the collection to memory before a search or a query
    #
    # @param collection_name [String] The name of the collection to load.
    # @param db_name [String] The name of the database of the collection (optional).
    # @return [Hash] Server response
    def load(collection_name:, db_name: nil)
      response = client.connection.post("#{PATH}/load") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
      end
      response.body.empty? ? true : response.body
    end

    # This operation returns the load status of a specific collection.
    #
    # @param collection_name [String] The name of the collection to get the load status of.
    # @param db_name [String] The name of the database of the collection (optional).
    # @param partition_names [String] The names of the partitions of the collection to get load status for (optional).
    # @return [Hash] Server response
    def get_load_state(collection_name:, db_name: nil, partition_names: nil)
      response = client.connection.post("#{PATH}/get_load_state") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
        req.body[:partitionNames] = partition_names if partition_names
      end
      response.body
    end

    # Release a collection from memory after a search or a query to reduce memory usage
    #
    # @param collection_name [String] The name of the collection to release.
    # @param db_name [String] The name of the database of the collection (optional).
    # @return [Hash] Server response
    def release(collection_name:, db_name: nil)
      response = client.connection.post("#{PATH}/release") do |req|
        req.body = {
          collectionName: collection_name
        }
        req.body[:dbName] = db_name if db_name
      end
      response.body.empty? ? true : response.body
    end
  end
end
