class Sf < Formula
  desc "Agent-first CLI for the Signal Foundry data workspace"
  homepage "https://signal-foundry.app"
  url "https://github.com/nexaflow-io/signal-foundry-cli-releases/releases/download/cli-v0.5.1/signal-foundry-cli-0.5.1.tar.gz"
  sha256 "76d4b317e148c62993a46bfa7b93d229710f79ba8954fc87f3a603a534295b2c"
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
    assert_match "0.5.1", shell_output("#{bin}/sf version")
    assert_match "effectiveBaseUrl", shell_output("#{bin}/sf auth show --json")
  end
end
