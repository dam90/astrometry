# Adding index files to the Docker container
The image only contains one index file used to verify that the stack actually works.  The astrometry container will boot perfectly fine without any extra index files, however it probably won't solve most images.  Since the container uses the default astrometry.net configuration, it looks for index files residing in the folder `/usr/local/astrometery/data` inside the docker container.  There are a couple of different ways to do this, I'll suggest two.

## Mount the index files from a directory on your computer

If you have a directory containing all of your index `*.fits` files, you can simply mount that directory to the astrometry container at runtime.  When executing docker run you would add the following flag:

`-v /directory/with/index/files:/usr/local/astrometry/data`

This would mount all of the files in `/directory/with/index/files` on your computer to `/usr/local/astrometry/data` inside the container.  This will work fine and won't be much trouble if the location of your index files doesn't change.  This also allows you do easily add index files on the fly, since anything you drop into your index folder is immediately accessibly by the astrometry container.Â

## Mount the index files from a Docker volume

If this is more of a "production" thing you may want to create a docker volume to store your index data.  See Docker docs for understanding Docker volumes.

### Creating the index volume

1. Create a Docker volume.  We'll call it *astrometry_index*:

  `docker volume create astrometry_index`

2. Create a helper container (called *index_helper*) that will dump your index files into the docker volume:

  `docker create -v astrometry_index:/data --name index_helper dm90/astrometry`

3. Use `docker cp` to add your index files to the docker volume, which is mounted to the helper container.  *Notice the trailing "/." on the source directory: this will copy all the files, but not the parent directory into the container directory*

  `docker cp /directory/with/index/files/. helper:/data`

4. Remove our helper container, leaving a docker volume with your index files inside:

  `docker rm index_helper`

### Using the index volume

Once your index volume exists, you mount it as if it were a directory.  So now our docker run flag looks like this:

`-v astrometry_index:/usr/local/astrometry/data`

This can be nice since you don't need to remember the location of the index files, and allows for easy configuration across multiple servers, provided they all create docker volumes with the same name that contain the index files.

## TODO

* Provide a shell script for creating index volumes
* Write a container script for updating index volumes
