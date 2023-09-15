defmodule Custom5v5Web.CustomLive do
  use Custom5v5Web, :live_view

  alias Custom5v5.Players.Player

  def mount(_params, _session, socket) do
    changeset = Player.changeset(%Player{}, %{})
    form = to_form(changeset, as: "player")

    blueTeam = %{top: nil, jungle: nil, mid: nil, adc: nil, support: nil}
    redTeam = %{top: nil, jungle: nil, mid: nil, adc: nil, support: nil}

    options_post = ["top", "jungle", "mid", "adc", "support"]

    options_elo = ["Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "GrandMaster", "Challenger"]



    socket =
      socket
      |> assign(:form, form)
      |> assign(:blueTeam, blueTeam)
      |> assign(:redTeam, redTeam)
      |> assign(:options_post, options_post)
      |> assign(:options_elo, options_elo)

    {:ok, socket}

  end
  def render(assigns) do
    ~H"""
    <div class="w-full">
      <h1 class="text-center w-full text-3xl mt-16">Custom 5v5</h1>
      <div class="w-full">
      <.form for={@form} id="player_form" class="w-full" phx-submit="submit">
      <div class="flex justify-center w-full space-x-3">
        <.input field={@form[:name]} placeholder="name"  type="text" class="rounded-lg border-primary uppercase"/>
        <.input field={@form[:elo]} placeholder="elo"  type="select" prompt={"elo"} options={@options_elo} class="rounded-lg border-primary uppercase"/>
        <.input field={@form[:post]} placeholder="post"  type="select" prompt={"post"} options={@options_post} class="rounded-lg border-primary uppercase" />

        <button type="submit" class="text-center rounded-lg bg-gradient-to-tr from-orange-500  to-purple-600 cursor-pointer px-4 hover:scale-105 duration-300 text-white">
          <p>Ajouter</p>
        </button>
      </div>
      </.form>
      </div>

      <hr class="border w-full mt-6">

      <div class="flex justify-around">
        <div>
          <h2 class="text-lg text-blue-500 font-bold uppercase">Blue Team</h2>
          <div class="flex-col">
            <div><%= if @blueTeam.top do @blueTeam.top["name"] else "-" end  %></div>
            <div><%= if @blueTeam.jungle do @blueTeam.jungle["name"] else "-" end  %></div>
            <div><%= if @blueTeam.mid do @blueTeam.mid["name"] else "-" end  %></div>
            <div><%= if @blueTeam.adc do @blueTeam.adc["name"] else "-" end  %></div>
            <div><%= if @blueTeam.support do @blueTeam.support["name"] else "-" end  %></div>
          </div>
        </div>


        <div>
          <h2 class="text-lg text-red-500 font-bold uppercase">Red Team</h2>
          <div class="flex-col">
            <div><%= if @redTeam.top do @redTeam.top["name"] else "-" end  %></div>
            <div><%= if @redTeam.jungle do @redTeam.jungle["name"] else "-" end  %></div>
            <div><%= if @redTeam.mid do @redTeam.mid["name"] else "-" end  %></div>
            <div><%= if @redTeam.adc do @redTeam.adc["name"] else "-" end  %></div>
            <div><%= if @redTeam.support do @redTeam.support["name"] else "-" end  %></div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("submit", %{"player" => player_params}, socket) do
   IO.inspect(player_params)

    blueTeam = socket.assigns.blueTeam
    redTeam = socket.assigns.redTeam

    {blueTeam, redTeam} = insert(player_params, blueTeam, redTeam)


    socket=
      socket
      |> assign(:blueTeam, blueTeam)
      |> assign(:redTeam, redTeam)


    {:noreply, socket}
  end


  def insert(player, blueTeam, redTeam) do
    {blueTeam, redTeam} =
    if player["post"] == "top" do
      if blueTeam.top == nil do
        blueTeam = Map.put(blueTeam, :top, player)
        {blueTeam, redTeam}
      else
        if redTeam.top == nil do
          redTeam = Map.put(redTeam, :top, player)
          {blueTeam, redTeam}
        else
          {blueTeam, redTeam}
        end
      end
    end

    {blueTeam, redTeam}
  end

end
