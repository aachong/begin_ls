import torch

x = torch.ones(1000, 1000).to('cuda:0')

while True:
    x = x * x
