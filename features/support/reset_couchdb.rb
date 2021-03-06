require 'rapidftr_default_db_setup'

Before do
  Session.all.each {|s| s.destroy }
  Child.all.each {|c| c.destroy }
  User.all.each {|u| u.destroy }
  SuggestedField.all.each {|u| u.destroy }
  RapidFTR::DbSetup.reset_default_form_section_definitions
end
