defmodule Clark.Layouts.RootLayout do
  use Clark.Component
  use Tableau.Layout

  def template(assigns) do
    temple do
      "<!DOCTYPE html>"

      html lang: "en" do
        head do
          meta(charset: "utf-8")
          meta(http_equiv: "X-UA-Compatible", content: "IE=edge")
          meta(name: "viewport", content: "width=device-width, initial-scale=1.0")

          link(rel: "stylesheet", href: "/css/site.css")
        end

        body class: "font-sans" do
          div id: "the-universe" do
            header class: "top-0 sticky z-10 w-full bg-white dark:bg-zinc-900 mx-auto p-2 border-b-2 border-zinc-950 dark:border-white" do
              h1 class: "text-xl font-semibold", do: "clark lindsay"
              a href: "/about", class: "text-zinc-950 dark:text-white hover:underline", do: "about"
            end

            main class: "h-full mx-auto px-2 py-2" do
              render(@inner_content)
            end
          end

          c(&footer/1)
        end

        if Mix.env() == :dev do
          c(&Tableau.live_reload/1)
        end
      end
    end
  end

  def footer(assigns) do
    temple do
      footer class: "container py-4 px-4 border-t-2 border-zinc-950 dark:border-white w-full" do
        div do
          h4(class: "text-lg font-medium mb-2", do: "Site")

          ul do
            li do
              a href: "/feed.xml", class: "text-zinc-950 dark:text-white hover:underline" do
                "RSS"
              end
            end

            li do
              a href: "https://github.com/clark-lindsay/clark-lindsay.github.io",
                class: "text-zinc-950 dark:text-white hover:underline" do
                "Source Code"
              end
            end

            li class: "italic text-sm mt-2" do
              span(do: "Built with")

              a(
                class: "underline",
                href: "https://github.com/elixir-tools/tableau",
                do: "Tableau,"
              )

              a(
                class: "underline",
                href: "https://tailwindcss.com",
                do: "TailwindCSS,"
              )
            end
          end
        end
      end
    end
  end
end
