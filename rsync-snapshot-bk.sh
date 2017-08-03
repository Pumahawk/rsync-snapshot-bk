# autore: lorenzo gandino


DATE_FORMAT="+%M.%H-%Y.%m.%d"
SNAPSHOT_DIR=$(date $DATE_FORMAT)

echo "START $(date)"

if [ ! $# = 2 ]
then
	echo "Errore. Digitare ${0} <source> <dest>"
	exit 1;
fi

SOURCE=$1
DEST=$2
LAST_BK_DIR="${DEST}/last"
SNAPSHOT_DIR="${DEST}/snapshot/${SNAPSHOT_DIR}"

if [ ! -d "$DEST" ]
then
	echo "Errore cartella: $DEST"
	exit 1;
fi;

if [ ! -d "${LAST_BK_DIR}" ]
then
	mkdir -p "${LAST_BK_DIR}"
fi;

rsync -av --delete "$SOURCE" "$LAST_BK_DIR" || exit 1


if [ ! -d "${SNAPSHOT_DIR}" ]
then
	mkdir -p "${SNAPSHOT_DIR}"
fi;

cp -arl "${LAST_BK_DIR}/." "${SNAPSHOT_DIR}"

echo "END $(date)"
