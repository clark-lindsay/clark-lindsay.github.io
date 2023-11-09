defmodule Clark.Pages.HomePage do
  @moduledoc false
  use Clark.Component

  use Tableau.Page,
    layout: Clark.Layouts.RootLayout,
    permalink: "/"

  def template(assigns) do
    temple do
      section do
        p class: "px-2" do
          ul class: "flex flex-col gap-2" do
            for post <- @posts do
              li class: "list-none" do
                a class: " hover:text-purple-500", href: post.permalink do
                  span(
                    class: "text-xl font-semibold",
                    do: post.title
                  )

                  span(do: "(#{Calendar.strftime(post.date, "%04Y-%02m-%02d")})")
                end
              end
            end
          end
        end
      end
    end
  end
end
