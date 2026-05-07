import { StoreComponent } from "@/app/_components/page/store/StoreComponent";
import { fetchPlans } from "@/app/_services/public/planService";
import { Plan } from "@/app/types";

// Render at request time, not build time (API not available during build)
export const dynamic = 'force-dynamic';

export default async function StorePage() {
  const plans: Plan[] = await fetchPlans('GAME_SERVER');

  return (
  <div>
    <StoreComponent plans={plans} />
  </div>);
}