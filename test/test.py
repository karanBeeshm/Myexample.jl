import numpy as np
import matplotlib.pyplot as plt
import time

def solve_system(f, u0, p, n):
    u = np.array(u0)
    for i in range(n-1):
        u = f(u, p)
    return u

def lorenz(u, p):
    alpha, sigma, rho, beta = p
    du1 = u[0] + alpha * (sigma * (u[1] - u[0]))
    du2 = u[1] + alpha * (u[0] * (rho - u[2]) - u[1])
    du3 = u[2] + alpha * (u[0] * u[1] - beta * u[2])
    return np.array([du1, du2, du3])

def solve_system_save(f, u0, p, n):
    u = np.empty((n, len(u0)))
    u[0] = u0
    for i in range(1, n):
        u[i] = f(u[i-1], p)
    return u

# Parameters: α, σ, ρ, β
p = (0.02, 10.0, 28.0, 8/3)

# Initial conditions
u0 = [1.0, 0.0, 0.0]

# Number of iterations
n = 10000

# Measure the execution time of the simulation
start_time = time.time()

# Solve the system and save the results
to_plot = solve_system_save(lorenz, u0, p, n)

# End the timing
end_time = time.time()

# Calculate the duration
execution_time = end_time - start_time

# Print the execution time
print(f"Simulation execution time: {execution_time:.4f} seconds")

# Plotting the Lorenz Attractor
x = to_plot[:, 0]
y = to_plot[:, 1]
z = to_plot[:, 2]

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot(x, y, z)
ax.set_title("Lorenz Attractor")
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")
plt.show()
