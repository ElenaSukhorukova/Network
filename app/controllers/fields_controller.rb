# frozen_string_literal: true

class FieldsController < ApplicationController
  # POST /fields/:model(/:id)/build/:association(/:partial)
  def build
    resource_class      = params[:model].classify.constantize
    association_class   = resource_class.reflect_on_association(params[:association]).klass
    fields_partial_path = params[:partial] || "#{association_class.model_name.collection}/fields"
    render locals: { resource_class: resource_class, association_class: association_class,
                     fields_partial_path: fields_partial_path }
  end
end
