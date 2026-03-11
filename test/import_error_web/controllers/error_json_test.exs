defmodule ImportErrorWeb.ErrorJSONTest do
  use ImportErrorWeb.ConnCase, async: true

  test "renders 404" do
    assert ImportErrorWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ImportErrorWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
