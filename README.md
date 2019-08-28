# Applying reinforcement learning in cataract surgery
A 3-D simulation environment is released here to train a reinforcement learning agent to perform surgical tasks. This
environment is based on Unity. The environment consists of an eye with one small incision and the capsulorhexis cystotome canula, as illustrated in the figure below. The eye elements modeled are: cornea, iris, capsule lens, transparent lens and sclera. At the moment, one task of cataract surgery has been modeled: capsulorhexis. The purpose of this task is to open the transparent capsule containing the diseased crystalline lens. The most commonly used technique to perform this task is a full-circle tear of the anterior face of the lens capsule. Then, the task in the environment is to have the tooltip makes a circular incision on the front side of the capsule lens.

# PPO agent
![Agent is doing the task](env_video-view-1.gif)
A PPO agent is trained to perform the capsulorhexis task using the 3-D coordinates and the motion vectors of the tool. The model-free agent is trained with handcrafted dense rewards, guiding the policy optimisation
towards more promising solutions. The reward strategy is based on two factors: the distance to the lens and the
incision shape done by the agent on the capsule lens. In other words, moving towards the lens gives the agent
positive rewards and moving away from the lens gives the agent negative rewards. In addition, circular incision on
the capsule lens gives positive rewards and non-circular one gives negative rewards.

The gif below shows a reinforcement learning agent episode where the agent had access to the
3-D coordinates and motion vectors: the surgical instrument enters through a small incision visible on the right
side of the eye and makes a circular incision on the front side of the capsule. This episode shows that the agent is
able to incise a roughly circular piece of the lens capsule. This highly demonstrates the ability of a RL agent to
perform this surgical task.

# Dependencies


# Copyright
Copyright © 2018-2019 [LaTIM U1101 Inserm](http://latim.univ-brest.fr/)




