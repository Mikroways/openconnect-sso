# Openconnect sso wrapper

This container solves the problem of connecting against openconnect using SSO.
It requires to install python, pipx and [openconnect-sso](https://github.com/vlaci/openconnect-sso).

At Mikroways we use to connect to multiple VPN, depending of our client needs.
And some times we also work in a headless mode. For these reasons, we build this
conatiner image, to easily connect to VPN appliances when SSO is needed.

As a requirement, this python wrapper saves credentials inside gnome keystore
and prompts user asking for credentials. The purpose of this container is to
avoid using X11 and any other graphical requirements.

## Usage

Run container using:

```bash
docker run -it --rm \
    --net host \
    --env PASSWORD='Sup3r$ecr3t' \
    --cap-add=NET_ADMIN  \
    ghcr.io/mikroways/openconnect-sso:latest \
        --server https://vpn.example.com \
        -g vpn-group \
        --user user@email.com
```

VPN is established or failed after 30 seconds if no connected string is
received. In case of password failure or other errors, a GUI will help you debug
what is happening.

### Start with UI

You can change the way this container works, chnaging headless mode to open a
graphical window:

```bash
docker run -it --rm \
    --net host \
    --env PASSWORD='Sup3r$ecr3t' \
    --env QT_QPA_PLATFORM=xcb \
    --env DISPLAY=$DISPLAY \
    --volume /tmp/.X11-unix/:/tmp/.X11-unix/ \
    --cap-add=NET_ADMIN  \
    ghcr.io/mikroways/openconnect-sso:latest \
        --server https://vpn.example.com \
        -g vpn-group \
        --user user@email.com
```

