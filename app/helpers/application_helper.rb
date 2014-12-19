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
end
