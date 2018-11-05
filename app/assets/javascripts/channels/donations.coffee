html = (htmlString) ->
  div = document.createElement('div')
  div.innerHTML = htmlString.trim()
  div.firstChild
slug = window.location.pathname.replace('/','')
App.donations = App.cable.subscriptions.create { channel: "DonationsChannel", slug: slug },
  collection: -> document.querySelector('[data-channel="donations"]')
  connected: ->
    console.log('DonationsChannel connected')

  disconnected: ->
    console.log('DonationsChannel disconnected')

  received: (data) ->
    console.log('DonationsChannel', data)
    @update_totals(data.raised)
    @collection().appendChild(html(data.donation))

  update_totals: (raised) ->
    document.getElementById('raised').innerText = raised if document.getElementById('raised') != null
