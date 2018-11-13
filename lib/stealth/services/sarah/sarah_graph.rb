require 'graphql/client'
require 'graphql/client/http'

module SarahGraph
  HTTP = GraphQL::Client::HTTP.new('http://sarah:3000/graph')
  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  SendStealthResponse = SarahGraph::Client.parse <<-'GRAPHQL'
    mutation (
      $encounter_id: Int!,
      $body: String!,
      $responseHelper: ResponseHelperAttributes!,
    ) {
      sendStealthResponse(
        encounterId: $encounter_id,
        body: $body,
        responseHelper: $responseHelper
      ) { status }
    }
  GRAPHQL

  PossiblePatientsByEncounter = SarahGraph::Client.parse <<-'GRAPHQL'
    query ($id: Int!) {
      encounter(id: $id) {
        user {
          patients {
            id
            person {
              firstName
              lastName
            }
          }
        }
      }
    }
  GRAPHQL

  PossiblePractitionersByEncounter = SarahGraph::Client.parse <<-'GRAPHQL'
    query ($id: Int!) {
      encounter(id: $id) {
        clinic {
          name
          practitioners {
            id
            person {
              firstName
              lastName
            }
          }
        }
      }
    }
  GRAPHQL

  EncounterStatus = SarahGraph::Client.parse <<-'GRAPHQL'
    query ($id: Int!) {
      encounter(id: $id) {
        status
      }
    }
  GRAPHQL

  UpdateEncounter = SarahGraph::Client.parse <<-'GRAPHQL'
    mutation (
      $id: Int!,
      $patient_id: Int,
      $practitioner_id: Int
    ) {
      updateEncounter(
        id: $id,
        patientId: $patient_id,
        practitionerId: $practitioner_id
      ) {
        encounter {
          id
          status
          patient { id }
          practitioner { id }
          clinic { id }
          user { id }
        }
      }
    }
  GRAPHQL
end
