# Chris's Mac Boostrapper

I hate the time it takes me to get a new workstation set up just how I like it, and always end up forgetting a setting or two. Like any constructively lazy engineer, I decided to automate the process.

This kicks off by running an inception script:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/cbw/bootstrap/main/go.sh)"
```

which will set up a working directory and download and unarchive the contents of this repoitory. It'll then run bootstrap.sh which installs a couple prerequisites (Homebrew, 1Password, and Ansible), and executes an Ansible playbook that does all of the rest.

This isn't directly usable by someone else (it uses my AWS credentials stored in a 1Password keychain to download application preferences), but the model should be usable to build your own.
