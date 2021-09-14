defmodule ChatWeb.MessageLive.Index do
  use ChatWeb, :live_view

  alias Chat.Session
  alias Chat.Session.Message

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Session.subscribe
    {:ok, assign(socket, :messages, list_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Session.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Session.get_message!(id)
    {:ok, _} = Session.delete_message(message)

    {:noreply, assign(socket, :messages, list_messages())}
  end

  @impl true
  def handle_info({:message_created, message}, socket) do
    {:noreply, update(socket, :messages, fn messages -> [message | messages] end)}
  end

  defp list_messages do
    Session.list_messages()
  end
end
