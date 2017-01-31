class GraphqlController < ApplicationController
  # POST /graphql
  def query
    variables = {}
    if params[:variables]
      variables = params[:variables] if params[:variables].is_a? ActionController::Parameters
      variables = JSON.parse(params[:variables]) if params[:variables].is_a? String
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
