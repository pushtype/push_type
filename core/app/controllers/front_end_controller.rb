class FrontEndController < ApplicationController

  include PushType::Filterable

  private

  def root_path?
    request.fullpath == '/'
  end

  def raise_404
    if root_path?
      render template: 'push_type/setup', layout: false, status: 404
    else
      raise ActiveRecord::RecordNotFound
    end
  end

end
