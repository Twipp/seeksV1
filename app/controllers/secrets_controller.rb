class SecretsController < ApplicationController
  def index

    @secret = Secret.all

    render 'index'
  end
end
