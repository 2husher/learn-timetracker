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

  def display_nav_item(controllername, displaytext, linkurl)
     raw("<li #{controller_name == controllername ? "class='active'" : ''}> #{link_to displaytext, linkurl}</li>")
  end
end
