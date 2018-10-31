App.campaign = App.cable.subscriptions.create { channel: "CampaignChannel", id: window.location.pathname.replace('/', '') },
  connected: ->
    alert('connected')

  disconnected: ->
    alert('disconnected')

  received: (data) ->
    alert('data')
    $('#donations').append data['donation']

  donate: (donation) ->
    @perform 'donate', donation: donation
