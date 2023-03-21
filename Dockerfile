FROM alpine:3.17

RUN apk add yq curl --no-cache

RUN curl -fsSLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c - && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN addgroup -g 1001 -S cop && adduser -u 1001 -S cop -G cop
USER cop
