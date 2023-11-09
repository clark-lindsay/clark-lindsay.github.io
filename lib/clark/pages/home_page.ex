defmodule Clark.Pages.HomePage do
  use Clark.Component

  use Tableau.Page,
    layout: Clark.Layouts.RootLayout,
    permalink: "/"

  def template(assigns) do
    temple do
      section do
        p class: "px-2" do
          ul do
            for post <- @posts do
              li class: "list-none" do
                a class: "text-lg", href: post.permalink, do: post.title
                span(do: "(#{Calendar.strftime(post.date, "%04Y-%02m-%02d")})")
              end
            end
          end
        end
      end
    end
  end
end
