class Sf < Formula
  desc "Agent-first CLI for the Signal Foundry data workspace"
  homepage "https://signal-foundry.app"
  url "https://github.com/nexaflow-io/signal-foundry-cli-releases/releases/download/cli-v0.3.30/signal-foundry-cli-0.3.30.tar.gz"
  sha256 "01ee66d15fdc0eb70614d7547d3f2055b35bf21fb2455bcdedfc119a581cc26c"
  license :cannot_represent

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    (bin/"sf").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@22"].opt_bin}/node" "#{libexec}/bin/sf.mjs" "$@"
    EOS
    chmod 0755, bin/"sf"
  end

  test do
    assert_match "0.3.30", shell_output("#{bin}/sf version")
    assert_match "effectiveBaseUrl", shell_output("#{bin}/sf auth show --json")
  end
end
