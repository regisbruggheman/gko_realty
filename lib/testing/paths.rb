module Gko::Realty::Paths
  def path_to(page)
    case page
    when 'path/to/realty'
    else
      super
    end
  end
end
World(Gko::Realty::Paths)


