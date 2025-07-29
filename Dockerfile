FROM debian:12-slim
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y openconnect python3 pipx \
            libglib2.0-0 libgl-dev \
            libatomic1 libnss3 libxcomposite1 libxdamage1 libxrandr2 libxtst6 \
            libdbus-1-3 libxkbcommon0 libxi6 libasound2 libgbm1 libxkbfile1 \
            libegl1 libxcb-cursor0 libxcb-icccm4 libxcb-keysyms1 libxcb-shape0 \
            libxkbcommon-x11-0 sudo gnome-keyring dbus libsecret-1-0 \
            gnome-keyring socat dbus-x11 libsecret-tools expect
RUN pipx install "openconnect-sso[full]==v0.8.1"
COPY ssl.conf /root/.ssl.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY openconnect-wrapper.expect /usr/local/bin/openconnect-wrapper.expect
ENV PATH=$PATH:/root/.local/bin \
    QT_QPA_PLATFORM=offscreen \
    QT_X11_NO_MITSHM=1 \
    QTWEBENGINE_DISABLE_SANDBOX=1 \
    OPENSSL_CONF=/root/.ssl.conf
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
