# == Schema Information
#
# Table name: projects
#
#  id           :bigint           not null, primary key
#  project_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord
  belongs_to :user
  has_many :cut_yields

  # NOTE: It seems like you're missing an assosiation with miter_frame here
end
