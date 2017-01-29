class GraphqlController < ApplicationController

  # POST /graphql
  def query
    context = {
      current_user: current_user
    }
    result = Schema.execute(params[:query], context: context)
    render json: result
  end
end
