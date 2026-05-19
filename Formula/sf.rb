class Sf < Formula
  desc "Agent-first CLI for the Signal Foundry data workspace"
  homepage "https://signal-foundry.app"
  url "https://github.com/nexaflow-io/signal-foundry-cli-releases/releases/download/cli-v0.3.10/signal-foundry-cli-0.3.10.tar.gz"
  sha256 "c0477a187090eb60b9054d1f81965270ca310fa8d1468212eba906bdb4ce43cb"
  license "LicenseRef-Signal-Foundry"

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
    assert_match "0.3.10", shell_output("#{bin}/sf version")
    assert_match "effectiveBaseUrl", shell_output("#{bin}/sf auth show --json")
  end
end