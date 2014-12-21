module ApplicationHelper

  def nav_items
    [
       {
        controllername: 'companies',
        displaytext: 'Companies',
        linkurl: companies_path
       },
       {
        controllername: 'projects',
        displaytext: 'Projects',
        linkurl: projects_path
       },
       {
        controllername: 'works',
        displaytext: 'Works',
        linkurl: works_path
       }
    ]
  end

  def sidebar
    unless ['sessions', 'registrations'].include?(controller_name)
      config = {}
      config[:index_title] = "All #{controller_name.capitalize}"
      config[:index_path]  = "#{controller_name}_path"
      config[:new_title]   = "New #{controller_name.singularize.capitalize}"
      config[:new_path]    = "new_#{controller_name.singularize}_path"
      render partial: 'shared/sidebar', locals: { config: config }
    end
  end
end
