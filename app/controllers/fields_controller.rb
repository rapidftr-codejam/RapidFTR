class FieldsController < ApplicationController

  FIELD_TYPES = %w{text_field textarea check_box select_drop_down}

  def read_form_section
    @form_section = FormSection.get_by_unique_id(params[:formsection_id])
  end

  def index
    read_form_section()
  end

  def new
    @body_class = 'forms-page'
    read_form_section()
    @suggested_fields = SuggestedField.all_unused
    render params[:fieldtype]
  end

  def create
    @form_section = FormSection.get_by_unique_id(params[:formsection_id])
    field =  Field.new(params[:field])
    
    begin
      FormSection.add_field_to_formsection @form_section, field
      SuggestedField.mark_as_used(params[:from_suggested_field])  if params.has_key? :from_suggested_field
      flash[:notice] = "Field successfully added"
      redirect_to(formsection_fields_path(params[:formsection_id]))
    rescue Exception => e
      field.errors.add("name", e.message)
      @field = field
      render :action => "new_#{params[:field][:type]}"
    end
  end

  def move_up
    FormSection.get_by_unique_id(params[:formsection_id]).move_up_field(params[:field_name])

    redirect_to(formsection_fields_path(params[:formsection_id]))
  end


  def move_down
    FormSection.get_by_unique_id(params[:formsection_id]).move_down_field(params[:field_name])

    redirect_to(formsection_fields_path(params[:formsection_id]))
  end

  FIELD_TYPES.each do |field_type|
    define_method "new_#{field_type}" do
      read_form_section()
    end
  end
end
