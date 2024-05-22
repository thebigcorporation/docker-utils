# SPDX-License-Identifier: GPL-3.0
ARG BASE
FROM $BASE

ARG BASE
ARG RUN_CMD

LABEL org.opencontainers.image.base.digest=""
LABEL org.opencontainers.image.base.name="$BASE"
LABEL org.opencontainers.image.description="${RUN_CMD}"

# analytics package target - we want a new layer here, since different
# dependencies will have to be installed, sharing the common base above
RUN DEBIAN_FRONTEND=noninteractive apt -y install bash

ARG TEST="/test.sh"
COPY --chmod=0555 src/test/$RUN_CMD.sh ${TEST}

ARG ENTRY="/entrypoint.sh"
RUN echo "#!/bin/bash\n$RUN_CMD \$@" > ${ENTRY} && chmod ugo+rx ${ENTRY}
ENTRYPOINT [ "/entrypoint.sh" ]
