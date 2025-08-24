# configuration for the Hercules CI flake update effect
# https://flake.parts/options/hercules-ci-effects.html#opt-hercules-ci.flake-update.enable
{
  hercules-ci.flake-update = {
    enable = true;
    when.hour = 14;
    when.minute = 30;
  };
}
