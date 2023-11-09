defmodule Clark.Layouts.PageLayout do
  use Clark.Component
  use Tableau.Layout, layout: Clark.Layouts.RootLayout

  def template(assigns) do
    temple do
      div class: "container mx-auto px-2" do
        article class: "mx-auto max-w-4xl mb-8 pt-8" do
          div class: "flex items-center justify-between" do
            h1 class: "font-bold text-2xl" do
              @page.title
            end
          end

          hr(class: "mt-4 mb-8")

          article class:
                    "prose dark:prose-invert prose-a:text-purple-500 hover:prose-a:text-purple-700" do
            render(@inner_content)
          end
        end
      end
    end
  end
end
