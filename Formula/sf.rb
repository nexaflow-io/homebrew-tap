class Sf < Formula
  desc "Agent-first CLI for the Signal Foundry data workspace"
  homepage "https://signal-foundry.app"
  url "https://github.com/nexaflow-io/signal-foundry-cli-releases/releases/download/cli-v0.3.50/signal-foundry-cli-0.3.50.tar.gz"
  sha256 "dfa05c8a18fa7afe3fa77436c0cccc05cd6ce265d128f81121c399dcc5c20287"
  license :cannot_represent

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    (bin/"sf").write <<~EOS
      #!/bin/bash
      exec "#{formula_opt_bin("node@22")}/node" "#{libexec}/bin/sf.mjs" "$@"
    EOS
    chmod 0755, bin/"sf"
  end

  test do
    assert_match "0.3.50", shell_output("#{bin}/sf version")
    assert_match "effectiveBaseUrl", shell_output("#{bin}/sf auth show --json")
  end
end
