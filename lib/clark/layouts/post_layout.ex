defmodule Clark.Layouts.PostLayout do
  use Clark.Component
  use Tableau.Layout

  def template(assigns) do
    temple do
      "<!DOCTYPE html>"

      html lang: "en" do
        head do
          meta charset: "utf-8"
          meta http_equiv: "X-UA-Compatible", content: "IE=edge"
          meta name: "viewport", content: "width=device-width, initial-scale=1.0"

          link rel: "stylesheet", href: "/css/site.css"
        end

        body do
          main class: "container mx-auto px-2" do
            h2 class: "text-lg font-semibold", do: @page.title

            render(@inner_content)
          end
        end

        if Mix.env() == :dev do
          c &Tableau.live_reload/1
        end
      end
    end
  end
end