const core = require('@actions/core');
const github = require('@actions/github');
const child_process = require('child_process');

try {
  child_process.execSync("wget -O KWSourceScanBin.zip.gpg https://github.com/dohuutamhuy/CustomGithubAction/blob/master/KWSourceScanBin.zip.gpg?raw=true  > /dev/null 2>&1");
  const passphrase = core.getInput('secret');
  child_process.execSync(`gpg -d -o "KWSourceScanBin.zip" --pinentry-mode=loopback --passphrase ${ passphrase} KWSourceScanBin.zip.gpg  > /dev/null 2>&1`);
  child_process.execSync("unzip KWSourceScanBin.zip  > /dev/null 2>&1");
  child_process.execSync("mv KWSourceScanBin ..");
  var a = child_process.execSync("../KWSourceScanBin/KWSourceScan");
  var str = a.toString().trim()  
  core.setOutput("result", str)
  child_process.execSync("rm KWSourceScanBin.zip");
  child_process.execSync("rm -rf ../KWSourceScanBin");
} catch (error) {
  core.setFailed(error.message);
}
