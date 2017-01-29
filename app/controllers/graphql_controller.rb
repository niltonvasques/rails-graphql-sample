class GraphqlController < ApplicationController
  # POST /graphql
  def query
    variables = {}
    variables = JSON.parse(params[:variables]) if params[:variables]

    result = Schema.execute(
      params[:query],
      variables: variables,
      context: {
        current_user: current_user
      }
    )
    render json: result
  end
end
