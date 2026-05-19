import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  private var fullscreenEventSink: FlutterEventSink?

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    configureFullscreenChannel(flutterViewController: flutterViewController)

    super.awakeFromNib()
  }

  private func configureFullscreenChannel(flutterViewController: FlutterViewController) {
    let fullscreenChannel = FlutterMethodChannel(
      name: "bingetube/fullscreen",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )
    fullscreenChannel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else {
        result(false)
        return
      }

      switch call.method {
      case "enterFullscreen":
        self.enterNativeFullscreen()
        result(true)
      case "exitFullscreen":
        self.setNativeFullscreen(false)
        result(false)
      case "isFullscreen":
        result(self.isNativeFullscreen)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    let fullscreenEvents = FlutterEventChannel(
      name: "bingetube/fullscreen_events",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )
    fullscreenEvents.setStreamHandler(self)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(fullscreenStateChanged),
      name: NSWindow.didEnterFullScreenNotification,
      object: self
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(fullscreenStateChanged),
      name: NSWindow.didExitFullScreenNotification,
      object: self
    )
  }

  private var isNativeFullscreen: Bool {
    return styleMask.contains(.fullScreen)
  }

  private func setNativeFullscreen(_ enabled: Bool) {
    if isNativeFullscreen != enabled {
      toggleFullScreen(nil)
    }
  }

  private func enterNativeFullscreen() {
    if isNativeFullscreen {
      return
    }

    if !isZoomed {
      zoom(nil)
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { [weak self] in
      guard let self = self, !self.isNativeFullscreen else {
        return
      }
      self.toggleFullScreen(nil)
    }
  }

  @objc private func fullscreenStateChanged() {
    fullscreenEventSink?(isNativeFullscreen)
  }
}

extension MainFlutterWindow: FlutterStreamHandler {
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    fullscreenEventSink = events
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    fullscreenEventSink = nil
    return nil
  }
}
