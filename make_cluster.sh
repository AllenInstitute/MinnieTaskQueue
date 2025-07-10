export USER=forrestc
gcloud config set project em-270621

gcloud beta container --project "em-270621" clusters create "${USER}-cluster-1" --zone "us-west1-a" --tier "standard" --no-enable-basic-auth --cluster-version "1.32.4-gke.1106006" --release-channel "regular" --machine-type "e2-standard-8" --image-type "COS_CONTAINERD" --disk-type "pd-balanced" --disk-size "100" --metadata disable-legacy-endpoints=true --spot --num-nodes "1" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,DAEMONSET,HPA,JOBSET,CADVISOR,KUBELET,DCGM --enable-ip-alias --network "projects/em-270621/global/networks/default" --subnetwork "projects/em-270621/regions/us-west1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --enable-autoscaling --min-nodes "0" --max-nodes "40" --location-policy "ANY" --enable-ip-access --security-posture=standard --workload-vulnerability-scanning=disabled --no-enable-google-cloud-access --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --binauthz-evaluation-mode=DISABLED --enable-managed-prometheus --enable-shielded-nodes --shielded-integrity-monitoring --no-shielded-secure-boot --node-locations "us-west1-a"

gcloud container clusters get-credentials --zone us-west1-a ${USER}-cluster-1

kubectl create secret generic secretsh01 \
  --from-file=google-secret.json \
  --from-file=aws-secret.json=$HOME/.cloudvolume/secrets/aws-secret.json \
  --from-file=cave_datastack_to_server_map.json=$HOME/.cloudvolume/secrets/cave_datastack_to_server_map.json

kubectl create secret generic boto \
--from-file=minimal_boto 