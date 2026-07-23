class Sf < Formula
  desc "Agent-first CLI for the Signal Foundry data workspace"
  homepage "https://signal-foundry.app"
  url "https://github.com/nexaflow-io/signal-foundry-cli-releases/releases/download/cli-v0.3.46/signal-foundry-cli-0.3.46.tar.gz"
  sha256 "fb6a597ab82a66bb29a306c7d73ae5c1f17bdbb93901ef70b563bcc11d719f44"
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
    assert_match "0.3.46", shell_output("#{bin}/sf version")
    assert_match "effectiveBaseUrl", shell_output("#{bin}/sf auth show --json")
  end
end
