# ffmpeg -i exodus-1.mp4 -vcodec libx265 -crf 22 -vf scale=-1:720 exodus-1-min.mp4
# ffmpeg -i exodus-3.mp4 -vcodec libx265 -crf 22 -vf scale=-1:720 exodus-3-min.mp4
# ffmpeg -i exodus-4.mp4 -vcodec libx265 -crf 22 -vf scale=-1:720 exodus-4-min.mp4
# ffmpeg -i exodus-5.mp4 -vcodec libx265 -crf 22 -vf scale=-1:720 exodus-5-min.mp4

for var in "$@"
do
    extension="${var##*.}"
    filename="${var%.*}"
    newfilename="${filename}-min.${extension}"
    # echo $newfilename
    ffmpeg -i $var -vcodec libx265 -crf 22 -vf scale=-1:720 $newfilename 
done

