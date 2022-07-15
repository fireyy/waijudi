/// Current state of the player.
///
/// Find more about it [here](https://fijkplayer.befovy.com/docs/zh/fijkstate.html#gsc.tab=0).
enum PlayerState {
  /// Denotes State when player is not loaded with video.
  unknown,

  /// Denotes state when player loads first video.
  unStarted,

  /// Denotes state when player has ended playing a video.
  ended,

  /// Denotes state when player is playing video.
  playing,

  /// Denotes state when player is paused.
  paused,

  /// Denotes state when player is buffering bytes from the internet.
  buffering,

  /// Denotes state when player loads video and is ready to be played.
  cued,
}
