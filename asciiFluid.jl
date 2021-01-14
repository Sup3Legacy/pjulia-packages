include("matrix.jl")
include("random.jl")

WIDTH = 80
HEIGHT = 24

mutable struct Ref val; end;

xSandboxAreaScan  = 0
ySandboxAreaScan  = 0
xPos = newarray(2 * WIDTH * HEIGHT, 0)
yPos = newarray(2 * WIDTH * HEIGHT, 0)
density = newarray(2 * WIDTH * HEIGHT, 0.)
wallflag = newarray(2 * WIDTH * HEIGHT, 0)
xForce = newarray(2 * WIDTH * HEIGHT, 0.)
yForce = newarray(2 * WIDTH * HEIGHT, 0.)
xVelocity = newarray(2 * WIDTH * HEIGHT, 0.)
yVelocity = newarray(2 * WIDTH * HEIGHT, 0.)

totalOfParticles = Ref(0)
gravity = 0
pressure = 4
viscosity = 7

chars = " '`-.|//,\\|\\_\\/#"

#particlesCounter = Ref(0)

screenPreBuffer = matrix::make_matrix(3, [WIDTH, HEIGHT, 4], 0)
screenBuffer = matrix::make_matrix(2, [WIDTH, HEIGHT], ' ')

function initiate()
    particlesCounter = 0
    for i = 0 : (WIDTH - 1)
        for j = 0 : (HEIGHT - 1)
            if (j == 0 || i == 0 || i >= WIDTH - 2 || j >= HEIGHT - 3)
                wallflag[particlesCounter] = 1;
                wallflag[particlesCounter + 1] = 1;
                totalOfParticles.val = totalOfParticles.val + 2;
                particlesCounter = particlesCounter + 2;
                xPos[particlesCounter] = i;
                yPos[particlesCounter] = 2*j;
                xPos[particlesCounter + 1] = i;
                yPos[particlesCounter + 1] = 2*j + 1;
            elseif i <= div(WIDTH, 2) && j >= 10
                xPos[particlesCounter] = i;
                   yPos[particlesCounter] = 2*j;

                    xPos[particlesCounter + 1] = i;
                    yPos[particlesCounter + 1] = 2*j + 1;

                    totalOfParticles.val = totalOfParticles.val + 2;
                    particlesCounter = particlesCounter + 2;
            end;
        end;
    end;
end;

function simulation()
    while true
        for particlesCursor = 0 : (totalOfParticles.val - 1)
            density[particlesCursor] = wallflag[particlesCursor] * 9.;

            for particlesCursor2 = 0 : (totalOfParticles.val - 1)
                xParticleDistance = xPos[particlesCursor] - xPos[particlesCursor2];
                yParticleDistance = yPos[particlesCursor] - yPos[particlesCursor2];
                particlesDistance = sqrt(xParticleDistance ^ 2 + yParticleDistance ^ 2);
                particlesInteraction = div(particlesDistance, 2.) - 1.;

                if (int(1 - particlesInteraction) > 0)
                    density[particlesCursor] = density[particlesCursor] + particlesInteraction ^ 2;
                end;
            end;
        end;

        for particlesCursor = 0 : (totalOfParticles.val - 1)
            yForce[particlesCursor] = gravity + 0.;
            xForce[particlesCursor] = 0.;

            for particlesCursor2 = 0 : (totalOfParticles.val - 1)
                xParticleDistance = xPos[particlesCursor] - xPos[particlesCursor2];
                yParticleDistance = yPos[particlesCursor] - yPos[particlesCursor2];
                particlesDistance = sqrt(xParticleDistance ^ 2 + yParticleDistance ^ 2);
                particlesInteraction = div(particlesDistance, 2.) - 1.;

                if (int(1. - particlesInteraction) > 0)
                    xForce[particlesCursor] = xForce[particlesCursor] + particlesInteraction * div(xParticleDistance * (3 - density[particlesCursor] - density[particlesCursor2]) * pressure + xVelocity[particlesCursor] * viscosity - xVelocity[particlesCursor2] * viscosity, density[particlesCursor]);
                    yForce[particlesCursor] = yForce[particlesCursor] + particlesInteraction * div(yParticleDistance * (3 - density[particlesCursor] - density[particlesCursor2]) * pressure + yVelocity[particlesCursor] * viscosity - yVelocity[particlesCursor2] * viscosity, density[particlesCursor]);
                end;
            end;
        end;

        for i = 0 : (WIDTH - 1)
            for j = 0 : (HEIGHT - 1)
                screenBuffer[i][j] = ' ';
                screenPreBuffer[i][j][0] = 0;
                screenPreBuffer[i][j][1] = 0;
                screenPreBuffer[i][j][2] = 0;
                screenPreBuffer[i][j][3] = 0;
            end;
        end;

        for particlesCursor = 0 : (totalOfParticles.val - 1)
            if wallflag[particlesCursor] == 0
                if (sqrt(xForce[particlesCursor] ^ 2 + yForce[particlesCursor] ^ 2) < 4.2)
                    xVelocity[particlesCursor] = xVelocity[particlesCursor] + div(xForce[particlesCursor], 10.);
                    yVelocity[particlesCursor] = yVelocity[particlesCursor] + div(yForce[particlesCursor], 10.);
                else
                    xVelocity[particlesCursor] = xVelocity[particlesCursor] + div(xForce[particlesCursor], 11.);
                    yVelocity[particlesCursor] = yVelocity[particlesCursor] + div(yForce[particlesCursor], 11.);
                end
                xPos[particlesCursor] = xPos[particlesCursor] + int(xVelocity[particlesCursor]);
                yPos[particlesCursor] = yPos[particlesCursor] + int(yVelocity[particlesCursor]);
            end

            x = xPos[particlesCursor];
            y = int(div(yPos[particlesCursor], 2));

            if (y >= 0 && y < HEIGHT - 1 && x >= 0 && x < WIDTH - 1)
                screenPreBuffer[x][y][3] = 1;
                screenPreBuffer[x + 1][y][2] = 1;

                screenPreBuffer[x][y + 1][1] = 1;
                screenPreBuffer[x + 1][y + 1][0] = 1;
            end
        end;

        for j = 0 : HEIGHT - 1
            for i = 0 : WIDTH - 1
                index = 8 * screenPreBuffer[i][j][3] + 4 * screenPreBuffer[i][j][2] + 2 * screenPreBuffer[i][j][1] + 1 * screenPreBuffer[i][j][0];
                screenBuffer[i][j] = chars[index];
                print(screenBuffer[i][j])
            end;
            println()
        end;
    delay(0)
    end
end