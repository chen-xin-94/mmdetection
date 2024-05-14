_base_ = [
    '../_base_/models/faster-rcnn_r50_fpn.py',
    '../_base_/datasets/cityscapes_detection.py',
    '../_base_/schedules/schedule_1x.py', '../_base_/default_runtime.py'
]

train_dataloader = dict(batch_size=16)

# NOTE: `auto_scale_lr` is for automatically scaling LR,
# USER SHOULD NOT CHANGE ITS VALUES.
# base_batch_size = (2 GPUs) x (16 samples per GPU)
auto_scale_lr = dict(base_batch_size=32)