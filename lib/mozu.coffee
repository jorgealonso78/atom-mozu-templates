MozuView = require './mozu-view'
{CompositeDisposable} = require 'atom'

module.exports = Mozu =
  mozuView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @mozuView = new MozuView(state.mozuViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @mozuView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mozu:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mozuView.destroy()

  serialize: ->
    mozuViewState: @mozuView.serialize()

  toggle: ->
    console.log 'Mozu was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
