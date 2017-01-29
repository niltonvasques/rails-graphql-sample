class GraphqlController < ApplicationController

  # POST /graphql
  def query
    context = {
      current_user: current_user
    }

    variables = {}
    if params[:variables]
      variables = JSON.parse(params[:variables])
    end

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
