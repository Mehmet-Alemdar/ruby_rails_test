class Api::V1::FactsController < ApplicationController
  def index
    @facts = Fact.all
    render json: @facts
  end

  def destroy_all
    if Fact.destroy_all
      render json: { message: 'All facts deleted' }, status: :ok
    else
      render json: { message: 'Failed to delete facts' }, status: :unprocessable_entity
    end
  end
end
