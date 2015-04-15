Rails.application.routes.draw do
  mount HelloCode::ActiveRecordUtils::Engine => "/hello_code_active_record_utils"
end
